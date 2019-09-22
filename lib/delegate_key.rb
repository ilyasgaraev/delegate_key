class Module
  def delegate_key(*methods, to: nil, prefix: nil, private: nil)
    unless to
      raise ArgumentError, "Delegation needs a target. Supply a keyword argument 'to' (e.g. delegate_key :key, to: :hash)."
    end

    if prefix == true && /^[^a-z_]/.match?(to)
      raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
    end

    method_prefix = if prefix
      "#{prefix == true ? to : prefix}_"
    else
      ""
    end

    location = caller_locations(1, 1).first
    file, line = location.path, location.lineno

    method_names = methods.map do |method|
      method_def = [
        "def #{method_prefix}#{method}",
        "  #{to}.public_send(:[], #{method.inspect})",
        "end"
      ].join ";"

      module_eval(method_def, file, line)
    end

    private(*method_names) if private
    method_names
  end
end
