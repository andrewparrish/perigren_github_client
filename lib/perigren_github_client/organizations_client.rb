module PerigrenGithubClient
  module OrganizationsClient
    def get_organization_users(organization_id)
      get(BASE_URL + "/orgs/#{organization_id}/members")
    end
  end
end
