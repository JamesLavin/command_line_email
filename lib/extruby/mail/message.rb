module Mail

  class Message

    def attach_selected(filenames, dir = '')
      filenames.each do |filename|
        add_file dir + filename
      end
    end

    def attach_all_from_directory(directory)
      Dir.glob(directory + '/*').each do |filepath|
        add_file filepath
      end
    end

  end

end
