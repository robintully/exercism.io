require_relative '../../lib/exercism/pipeline.rb'

module ExercismWeb
  module Routes
    class Pipeline < Core
     get '/pipeline/:slug' do
       @masterlist = APIEngine.new(:slug).problems_list
       erb :"pipeline/index", locals: { masterlist: @masterlist }
      end


     get '/pipeline/:track_id' do |track_id|
      track = X::Track.find(track_id)
      if track.implemented?
        erb :"languages/language", locals: {
          track: track,
          docs: X::Docs::Launch.new(track.repository),
        }
      else
        erb :"languages/not_implemented", locals: { track: track }
      end
    end
  end
end
end