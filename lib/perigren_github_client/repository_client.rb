module PerigrenGithubClient
  module RepositoryClient
    def get_content(owner_name, repo_name, path)
      get(BASE_URL + "/repos/#{owner_name}/#{repo_name}/contents/#{path}")
    end
  end
end
