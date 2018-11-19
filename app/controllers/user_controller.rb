class UserController < ApplicationController

    def register
        @provinces = Province.all
    end

    def register_submit
        username = params[:username]
        password = params[:password]
        password_confirmation = params[:password_confirmation]
        name = params[:name]
        address = params[:address]
        email = params[:email]
        province = params[:province]


        # If password is confirmed, hash password
        if password == password_confirmation
            salt = BCrypt::Engine.generate_salt
            encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    
            newUser = User.create({:username => username, :password_hash => encrypted_password, :name => name, :address => address, :province_id => province, :email => email})

            if newUser.valid?
                redirect_to root_path
            else
                flash[:message] = newUser.errors.full_messages.first 
                
                redirect_back fallback_location: root_path
            end
        else
            flash[:message] = "Passwords didn't match."

            redirect_back fallback_location: root_path
        end
    end

end
