require "spec_helper"

describe Module do
  let(:dummy_class) do
    Class.new do
      def symbol_hash
        { key: "value" }
      end

      def string_hash
        { "key" => "value" }
      end
    end
  end

  describe ".delegate_key" do
    subject(:method) { dummy_class.new.key }

    before do
      dummy_class.delegate_key :key, to: :symbol_hash
    end

    it { is_expected.to eq "value" }

    context "when key is string" do
      before do
        dummy_class.delegate_key "key", to: :string_hash
      end

      it { is_expected.to eq "value" }

      context "but hash does NOT have this key" do
        before do
          dummy_class.delegate_key "key", to: :symbol_hash
        end

        it { is_expected.to be_nil }
      end
    end

    context "when :to param is NOT defined" do
      it "raises ArgumentError exception" do
        expect { dummy_class.delegate_key :key }.to raise_error ArgumentError
      end
    end

    context "when :prefix params is defined" do
      before do
        dummy_class.delegate_key :key, to: :symbol_hash, prefix: :test
      end

      it "creates a method with prefix" do
        expect(dummy_class.new.test_key).to eq "value"
      end

      context "and equals to 'true'" do
        before do
          dummy_class.delegate_key :key, to: :symbol_hash, prefix: true
        end

        it "creates a method with generated prefix" do
          expect(dummy_class.new.symbol_hash_key).to eq "value"
        end
      end

      context "but :prefix param is NOT a method" do
        it "raises ArgumentError exception" do
          expect { dummy_class.delegate_key :key, prefix: nil }.to raise_error ArgumentError
        end
      end
    end
  end
end
