require "json"

module BaseGenerator
  def create_dir!
    # create parent dir if necessary
    ["../", ""].each do |parent_dir|
      Dir.mkdir("#{target}#{root_path}#{parent_dir}") unless Dir.exist?("#{target}#{root_path}#{parent_dir}")
    end
  end

  def write_file!(filename, content)
    puts "Writing '#{root_path}#{filename}'... (#{content.length} bytes)"

    File.open "#{target}#{root_path}#{filename}", 'wb' do |file|
      file.write(content)
    end
  end

  def to_lua(json)
    value_to_lua(json)
  end

  def value_to_lua(value)
    if value.is_a?(Numeric)
      value.to_s
    elsif value == !!value
      !!value ? "true" : "false"
    elsif value.is_a?(String)
      "\"" + value + "\""
    elsif value.is_a?(Hash)
      "{" + value.reject { |key, v| v.nil? }.map do |key, v|
        "#{key} = #{value_to_lua(v)}"
      end.join(",\n") + "}"
    elsif value.is_a?(Array)
      "{" + value.map { |v| value_to_lua(v) }.join(", ") + "}"
    else
      fail "Can't translate to a value: #{value}"
    end
  end

  def mod_path(path)
    # already got an absolute path?
    return path if path[0, 2] == "__"

    "__#{data.name}__/#{path}"
  end

  def to_ini(pairs)
    pairs.map do |pair|
      key, value = pair
      "#{key}=#{value}"
    end.join("\n")
  end
end
