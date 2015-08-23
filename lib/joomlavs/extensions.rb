# This file is part of JoomlaVS.

# JoomlaVS is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# JoomlaVS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with JoomlaVS.  If not, see <http://www.gnu.org/licenses/>.

module JoomlaVS
  module Extensions
    def display_reference(ref, base_url)
      return unless ref
      if ref.is_a?(Array)
        ref.each do |id|
          print_indent("Reference: #{base_url}#{id}/")
        end
      else
        print_indent("Reference: #{base_url}#{ref}/")
      end
    end

    def display_vulns(vulns)
      vulns.each do |v|
        print_line_break
        print_error("Title: #{v['title']}")
        display_reference v['edbid'], 'https://www.exploit-db.com/exploits/'
        display_reference v['cveid'], 'http://www.cvedetails.com/cve/'
        display_reference v['osvdbid'], 'http://osvdb.org/'
        print_info("Fixed in: #{v['fixed_in']}") if v['fixed_in']
        print_line_break
      end
    end

    def display_optional_extension_info(e)
      print_indent_unless_empty("Description: #{e[:description]}", e[:description])
      print_indent_unless_empty("Author: #{e[:author]}", e[:author])
      print_indent_unless_empty("Author URL: #{e[:author_url]}", e[:author_url])
    end

    def display_required_extension_info(e)
      print_good("Name: #{e[:name]} - v#{e[:version]}")
      print_indent("Location: #{e[:extension_url]}")
      print_indent("Manifest: #{e[:manifest_url]}")
    end

    def display_detected_extension(e)
      print_line_break
      display_required_extension_info(e)
      display_optional_extension_info(e)
      display_vulns(e[:vulns])
      print_horizontal_rule
    end
  end
end