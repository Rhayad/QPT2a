class User < ActiveRecord::Base
    attr_accessor :password, :password_old
    attr_accessible :username, :email, :password, :encrypt_password, :password_old, :password_confirmation, :firstname, :lastname, :street, :zip,  :city, :country, :phone

    has_many :groups,           :foreign_key => "user_id", :dependent => :destroy
    has_many :projects,         :foreign_key => "user_id", :dependent => :destroy
    has_many :todos,            :foreign_key => "user_id", :dependent => :destroy
    has_many :group_members,    :foreign_key => "user_id", :dependent => :destroy
    has_many :todo_users,       :foreign_key => "user_id", :dependent => :destroy
    has_one  :avatar,           :foreign_key => "user_id", :dependent => :destroy

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :username,  :presence => true,
                          :length   => { :maximum => 30 }
                      
    validates :email, :presence     => true,
                      :format       => { :with => email_regex },
                      :uniqueness   => { :case_sensitive => false }
                      
    # Automatically create the virtual attribute 'password_confirmation'.
    validates :password, :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..20 },                      
                         :on           => :create
     
    validates :password_old, :presence => true,
                             :on       => :updatePassword
    
    before_save :encrypt_password

    # ------------------------------------------------
    def self.authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil  if user.nil?
        return user if user.has_password?(submitted_password)
        return nil
    end

    # firsts finds the user by unique id, and then verifies that the salt, stored in the cookie, is the correct one for that user.
    def self.authenticate_with_salt(id, cookie_salt)
        user = find_by_id(id)
        (user && user.salt == cookie_salt) ? user : nil
    end   
                       
    # Return true if the user's password matches the submitted password.
    def has_password?(submitted_password)
        # Compare encrypted_password with the encrypted version of
        # submitted_password.        
        self.encrypted_password == encrypt(submitted_password)
    end     
    
    def encrypt(string)
        secure_hash("#{salt}--#{string}")
    end
    
    def check_password?(submitted_password)
        # Compare encrypted_password with the encrypted version of
        # submitted_password.              
        self.encrypted_password == encrypt(submitted_password)
    end    

    def setPassword(submitted_password)
        self.encrypted_password = submitted_password
    end

    # ------------------------------------------------
    def findUserByUsername(username)
        @user = User.where("username LIKE ? ", "%#{username}%")
    end  
    # ------------------------------------------------
    private        
        def encrypt_password
          self.salt = make_salt if new_record?
          self.encrypted_password = encrypt(password)
        end

        def make_salt
          secure_hash("#{Time.now.utc}--#{password}")
        end

        def secure_hash(string)
          Digest::SHA2.hexdigest(string)
        end 
end