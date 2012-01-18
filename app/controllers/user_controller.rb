class UserController < ApplicationController
  before_filter  :authenticate_user!, :except => 'show'

  #todo Kostya, how to deal with this?
  #I read an answer on stackoverflow and one guy said it's not good to use code from
  #helpers in controllers.
  #http://stackoverflow.com/questions/453762/nomethoderror-when-trying-to-invoke-helper-method-from-rails-controller
  #wtf?
  #following line just inserts code?
  include UserHelper

  def show
    begin
      @user = User.find params[:id]
    rescue
      redirect_to root_path
    end
  end

  def edit
    # user is only allowed to edit his own page
    @user = User.find params[:id]
    # redirect him cruelly
    redirect_to @user unless is_current_user_page? @user
  end

  def update
    params.select {|k| k.to_s.start_with? 'q'}.each do |k, v|
      answer = current_user.answers.find {|a| a.question_id.to_s == k.to_s.gsub('q', '')}
      if answer.nil?
        create_answer v, k.to_s.gsub('q', '') unless v.empty?
      else
        if v.empty?
          answer.destroy
        else
          answer.answerText = v
          answer.save
        end
      end
    end
    redirect_to current_user, :notice => (t :successfully_saved)
  end

  def create
    current_user.successful = params[:a] == 'Y'
    params.select {|k| k.to_s.start_with? 'q'}.each do |k, v|
      create_answer v, k.to_s.gsub('q', '') unless v.nil? or v.empty?
    end
    current_user.save
    respond_to do |format|
      format.html { redirect_to (current_user)}
      format.xml  { render :xml => 'ok'}
    end
  end

  def new

  end

  private

  def create_answer(answer_text, question_id)
    current_user.answers.create :answerText => answer_text, :question_id => question_id
  end

end
