class FiguresController < ApplicationController
    get "/figures" do
      @figures = Figure.all
      erb :'figures/index'
    end

    get '/figures/new' do
      @titles = Title.all
      @landmarks = Landmark.all
      erb :'figures/new'
    end

    get "/figures/:id" do
      @figure = Figure.find(params[:id])
      erb :'figures/show'
    end

    get "/figures/:id/edit" do
      @titles = Title.all
      @landmarks = Landmark.all
      @figure = Figure.find(params[:id])
      erb :'figures/edit'
    end

    post '/figures' do
      figure = Figure.create(name: params[:figure][:name])
      # binding.pry
      if !params[:landmark][:name].empty?
        figure.landmarks.create(name: params[:landmark][:name])
      elsif params[:figure][:landmark_ids]
        params[:figure][:landmark_ids].each do |id|
          figure.landmarks << Landmark.find(id)
        end
      end
      if !params[:title][:name].empty?
        figure.titles.create(name: params[:title][:name]) 
      elsif params[:figure][:title_ids]
        params[:figure][:title_ids].each do |id|
          figure.titles << Title.find(id)
        end
      end 
      figure.save
      redirect "/figures/#{figure.id}" 
    end

    patch '/figures/:id' do
      figure = Figure.find(params[:id])
      figure.name = params[:figure][:name]
  
      if !params[:landmark][:name].empty?
        figure.landmarks.create(name: params[:landmark][:name])
      elsif params[:figure][:landmark_ids]
        params[:figure][:landmark_ids].each do |id|
          landmark = Landmark.find(id)
          figure.landmarks << landmark unless figure.landmarks.include?(landmark)
        end
      end
      if !params[:title][:name].empty?
        figure.titles.create(name: params[:title][:name]) 
      elsif params[:figure][:title_ids]
        params[:figure][:title_ids].each do |id|
          title = Title.find(id)
          figure.titles << title unless figure.titles.include?(title)
        end
      end

      figure.save
      redirect "/figures/#{figure.id}"
    end

    delete 'figure/:id' do
      figure = Figure.find(params[:id])
      figure.destroy
      
      redirect '/figures'
    end
end
