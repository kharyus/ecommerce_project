class PagesController < ApplicationController
    def permalink
        @page = Page.find_by(permalink: params[:permalink])

        if @page.nil?
            redirect_to root_url
        else
            render :show
        end
    end

    def show
        @page = Page.find(params[:id])
    end
end
