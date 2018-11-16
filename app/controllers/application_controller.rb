class ApplicationController < ActionController::Base
    before_action :getCategories

    # Add categories to be used in search in every site.
    def getCategories
        @categories = []
        @categories << Category.new(name: "All", id: -1)
        @categories += Category.all
    end

end
