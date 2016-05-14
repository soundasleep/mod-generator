require "json"

module BaseGenerator
  def create_dir!
    Dir.mkdir("#{target}#{root_path}") unless Dir.exist?("#{target}#{root_path}")
  end

  def write_file!(filename, content)
    puts "Writing '#{root_path}#{filename}'... (#{content.length} bytes)"

    File.open "#{target}#{root_path}#{filename}", 'wb' do |file|
      file.write(content)
    end

    # puts content
    # puts ""
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
      "{" + value.map do |key, v|
        "#{key} = #{value_to_lua(v)}"
      end.join(",\n") + "}"
    elsif value.is_a?(Array)
      "{" + value.map { |v| value_to_lua(v) }.join(", ") + "}"
    else
      fail "Can't translate to a value: #{value}"
    end
  end

  def mod_path(path)
    "__#{data.name}__/#{path}"
  end
end
