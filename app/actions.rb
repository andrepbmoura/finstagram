# Controller - Handles client HTTP requests and sends HTTP responses 

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

end

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
    
    redirect to('/login')

  else
    
    erb(:signup)

   end
end

get '/login' do  

  erb(:login) 
  
end

post '/login' do
  
  username = params[:username]
  password = params[:password]

  user = User.find_by(username: username)

  if user && user.password == password

    session[:user_id] = user.id

      redirect to('/')

  else

    @error_message = "Login failed."

    erb(:login)

  end
end

get '/logout' do

  session[:user_id] = nil

  redirect to('/')

end


get '/finstagram_posts/new' do

  @finstagram_post = FinstagramPost.new
  erb(:"finstagram_posts/new")

end


post '/finstagram_posts' do
  
  photo_url = params[:photo_url]

  @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

  if @finstagram_post.save
    redirect(to('/'))
  else
    erb(:"finstagram_posts/new")
  end
end

get '/finstagram_posts/:id' do

  @finstagram_post = FinstagramPost.find(params[:id])

  erb(:"finstagram_posts/show")

end