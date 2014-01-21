module Neutral
  module Formats
    def css_format
      return [css_manifest('.css'), ' *='] if File.exist? css_manifest('.css')
      return [css_manifest('.css.sass'), ' //='] if File.exists? css_manifest('.css.sass')
      return [css_manifest('.sass'), ' //='] if File.exist? css_manifest('.sass')
      return [css_manifest('.css.scss'), ' //='] if File.exist? css_manifest('.css.scss')
      return [css_manifest('.scss'), ' //='] if File.exist? css_manifest('.scss')
    end

    private
    def css_manifest(extension)
      "app/assets/stylesheets/application#{extension}"
    end
  end
end
