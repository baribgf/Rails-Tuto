class MainController < ApplicationController
  def index
    @langs = Lang.all
  end

  def new
    @lang = params[:name]
    @year = params[:year]
    
    begin
      if @lang.length > 0 and @year.length > 0
        Lang.create(name: @lang, year: @year)
        render plain: "OK"
      end
    rescue => e
      puts e
      render plain: "NO"
    end
  end

  def delete
    id = params[:id]
   begin
    status = Lang.delete(id)
    if status != 1
      raise
    end
    render plain: "OK"
   rescue => exception
    puts exception
    render plain: "NO"
   end
  end
end
