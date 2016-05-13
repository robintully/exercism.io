require_relative '../../x'

module ExercismWeb
  module Routes
    class Pipeline < Core
      get '/pipeline' do
        binding.pry
        tracks = X::Track.all
        active, inactive = tracks.partition { |t| t.active? }
        inactive.sort! { |a, b| b.problems.count <=> a.problems.count }
        erb :"languages/index", locals: { active: active, inactive: inactive }
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
