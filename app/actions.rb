# Controller - Handles client HTTP requests and sends HTTP responses 

# Handle the GET request for '/' (Display all the Finstagram posts by descending order) - READ
get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

# Handle the GET request for '/signup' (Display a form signup for the user the fill out the info) - READ
get '/signup' do  #If a user navigates to the path "/signup"

  @user = User.new  #setup empty @user object
  erb(:signup)  # render "app/views/signup.erb"

end

# Handle the POST request for '/signup' (Create a User) - CREATE 
post '/signup' do  #If a user navigates to the path "/signup"

  #grab user input values from params
  email = params[:email]
  avatar_url = params[:avatar_url]
  username = params[:username]
  password = params[:password]
  
  # instantiate a User
  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
  
  if @user.save
    
    "User #{@user.username} saved!"

  else
    
    erb(:signup)

   end
end
