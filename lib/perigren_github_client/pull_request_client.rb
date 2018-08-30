module PerigrenGithubClient
  module PullRequestClient
    def get_pull_comments(owner_name, repo_name)
      get(BASE_URL + "/repos/#{owner_name}/#{repo_name}/pulls/comments")
    end
  end
end
