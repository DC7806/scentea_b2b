# frozen_string_literal: true

class SectionContentFieldGenerator
  attr_reader :section, :style

  delegate :name, to: :section_config

  def initialize(section:, style:)
    @section = section
    @style = style
  end

  def options
    option_keys = %i[title subtitle description link image]

    OpenStruct.new(section_config.attributes.slice(*option_keys))
  end

  def contents
    return @section.contents unless @section.new_record?

    Array.new(section_config.content_count) { section.contents.new }
  end

  private

    def section_config
      @section_config ||= SectionContentStyle.find_by(style: @style)
    end
end
