module Build

  class Path < Pathname

    # Extensioins are sorted by priority
    def self.extension_classes
      {
        javascripts: ['coffee', 'js'],
        stylesheets: ['sass', 'scss', 'less', 'css'],
        images: ['png', 'jpg', 'jpeg', 'gif']
      }
    end

    def initialize(path = nil)
      super(path || '.')
    end

    def minified?
      to_s.include?('.min.')
    end

    def member_of?(klass)
      extension?(Path.extension_classes.fetch(klass, []))
    end

    def descendant?(directory)
      !relative_path_from(Path.new(directory)).to_s.split('/').include?('..')
    end

    def prefix(path)
      Path.new(path).join(self)
    end

    def join(*elements)
      Path.new(super(*elements))
    end

    def extension?(extensions)
      extensions.any? do |extension|
        !!to_s.match(/\.#{extension}(?:[\W]|$)/)
      end
    end

  end

end
