class MailsController < ApplicationController
  before_action :admin_required

  def write_email
    @simplemail = SimpleMail.new 
    @simplemail.sender = current_user.email
    @simplemail.addressee = Person.find(params[:id]).email
  end

  def send_email
    @simplemail = SimpleMail.new(mail_params)
    if @simplemail.valid?
      UserMailer.send_email(@simplemail).deliver
      redirect_to submissions_path
    else
      render :write_email
    end
  end
  private
  def mail_params
    params.require(:simplemail).permit(:from,:to,:subject,:body)
  end
end
