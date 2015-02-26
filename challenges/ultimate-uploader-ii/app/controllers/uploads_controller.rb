class UploadsController < ApplicationController
  def index
    put_things_in_session
    @uploads = Dir.entries(Rails.root.join('uploads')).reject { |e| ['..', '.', '.gitkeep'].include? e }.map do |e|
      [e, "/uploads/#{e}"]
    end
  end

  def show
    filename = "#{params[:id]}.#{params[:format]}"
    #filename = params[:filename]
    send_file(Rails.root.join('uploads', filename))
  end

  def create
    uploaded_io = params[:file]
    File.open(Rails.root.join('uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    redirect_to uploads_path
  end

  private
  def put_things_in_session
    session[:nsa_watch_list] = true
    session[:secret] = File.read(Rails.root.join('secret')).strip
  end
end
