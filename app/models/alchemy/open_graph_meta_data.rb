module Alchemy
  class OpenGraphMetaData

    def initialize(page, request)
      @page = page
      @request = request
    end

    def open_graph_data
      open_graph_meta_string = %(
      #{open_graph_meta_tag_for('image', open_graph_image_data)}
      #{open_graph_meta_tag_for('title', open_graph_title_data)}
      #{open_graph_meta_tag_for('description', open_graph_description_data)}
      #{open_graph_meta_tag_for('url', open_graph_url_data)}
      #{open_graph_meta_tag_for('site_name', open_graph_site_name_data)}
      #{open_graph_meta_tag_for('type', open_graph_type_data)}
      )
      return open_graph_meta_string.html_safe
    end

    def open_graph_meta_tag_for(type, content)
      %(<meta property="og:#{type}" content="#{content}">)
    end

    def open_graph_image_data
      base_url = @request.base_url
      image = "#{base_url}#{ActionController::Base.helpers.image_path 'opengraph-image.jpg'}"
      image = "#{base_url}#{ActionController::Base.helpers.image_path @page.open_graph_image}" unless @page.open_graph_image.blank?
      return image
    end

    def open_graph_title_data
      title = 'Loot Crate - Monthly Geek and Gamer Subscription Box.'
      title = @page.open_graph_title unless @page.open_graph_title.blank?  
      return title
    end

    def open_graph_description_data
      description = 'Loot Crate is an epic monthly subscription box for geeks and gamers for under $20.'
      description = @page.open_graph_description unless @page.open_graph_description.blank? 
      return description
    end

    def open_graph_url_data
      url = @request.original_url
      url = @page.open_graph_url unless @page.open_graph_url.blank?
      return url
    end

    def open_graph_site_name_data
      site_name = 'Loot Crate'
      site_name = @page.open_graph_site_name unless @page.open_graph_site_name.blank?
      return site_name
    end

    def open_graph_type_data
      type = 'website'
      type = @page.open_graph_type unless @page.open_graph_type.blank?
      return type
    end

  end
end
