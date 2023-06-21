class Module
  def delegate_key(*methods, to: nil, prefix: nil, private: nil)
    unless to
      raise ArgumentError, "Delegation needs a target. Supply a keyword argument 'to' (e.g. delegate_key :key, to: :some_hash)."
    end

    if prefix == true && /^[^a-z_]/.match?(to)
      raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
    end

    method_prefix = prefix ? "#{prefix == true ? to : prefix}_" : ""

    location = caller_locations(1, 1).first
    file, line = location.path, location.lineno

    method_def = []
    method_names = methods.each do |method|
      method_def <<
        "def #{method_prefix}#{method}" <<
        "  #{to}.public_send(:[], #{method.inspect})" <<
        "end"
    end

    module_eval(method_def.join(";"), file, line)
    private(*method_names) if private
    method_names
  end
end
