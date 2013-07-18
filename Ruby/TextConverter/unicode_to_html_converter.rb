require 'cgi'

class UnicodeFileToHtmlTextConverter

    def initialize(full_filename_with_path)
        @full_filename_with_path = full_filename_with_path
    end

    def convert_to_html
        f = File.open(@full_filename_with_path, "r")
        html = ""
        f.each_line do |line| 
            line = line.rstrip()
            html += CGI::escapeHTML(line)
            html += "<br />"
        end

        return html
    end


end
