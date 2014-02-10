module Briar
  module Bundler
    module Gemfile

      class GitFile

        attr_reader :dot_file
        attr_reader :git_hash

        def initialize(gem_name)
          @dot_file = ".#{gem_name}-git"
        end

        def exists?
          File.exists?(@dot_file)
        end

        def branch
          git_hash[:branch]
        end

        def github
          git_hash[:github]
        end

        def git_hash
          return @git_hash unless @git_hash.nil?
          branch_info = IO.readlines(@dot_file)
          path = branch_info[0].strip
          branch = branch_info[1].strip
          @git_hash = {:github => path, :branch => branch}
        end
      end

    end
  end
end
