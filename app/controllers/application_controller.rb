class ApplicationController < ActionController::API
  before_action :set_current_user

  {
    Nighty::BadRequest => :bad_request,
    Nighty::NotFound => :not_found
  }.each do |klass, status|
    rescue_from klass do |exception|
      data = {
        message: exception.message
      }

      render json: data, status: status
    end
  end

  private

  ##
  # For this demo we'll assume that the user
  # with id of 1 is the authenticated user
  #
  def set_current_user
    Current.user = User.find(1)
  end

  def set_pagination_header(name)
    relation = instance_variable_get("@#{name}")

    page = {}
    page[:next] = relation.current_page + 1 unless relation.last_page?
    page[:prev] = relation.current_page - 1 unless relation.first_page?

    links = []

    page.each do |key, value|
      uri = URI.parse(request.original_url)
      new_params = URI.decode_www_form(uri.query || "") + [[:page, value]]
      uri.query = URI.encode_www_form(new_params)

      links << "<#{uri}>; rel=\"#{key}\""
    end

    headers["Link"] = links.join(", ") unless links.empty?
  end
end
