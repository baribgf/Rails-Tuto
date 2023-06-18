=begin
    set(path, data, query_options)
    get(path, query_options)
    push(path, data, query_options)
    delete(path, query_options)
    update(path, data, query_options)
=end

class MainController < ApplicationController
  def initialize
    base_uri = 'https://rails-tuto-42622-default-rtdb.europe-west1.firebasedatabase.app/'
    firebase_db_key = File.open('firebase-db-key.json').read
    @firebase = Firebase::Client.new(base_uri, firebase_db_key)
    @lang_db_name = "langs"
  end

  def index
    @langs = {}
    n = 0
    begin
      for i in @firebase.get(@lang_db_name).body do
        n += 1
        i[0] = n
        @langs.store(i[0], i[1])
      end
    rescue => e
    end
  end

  def new
    lang = params[:name]
    year = params[:year]
    
    begin
      if lang.length > 0 and year.length > 0
        @firebase.push(@lang_db_name, {name: lang, year: year})
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
      status = @firebase.delete(@lang_db_name + "/" + @firebase.get(@lang_db_name).body.keys[id.to_i - 1])
      if status.code != 200
        raise
      end
      render plain: "OK"
    rescue => exception
      puts exception
      render plain: "NO"
    end
  end
end
