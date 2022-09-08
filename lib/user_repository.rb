require_relative 'user'
require_relative 'database_connection'


class UserRepository
    def create(new_user)
    #   encrypted_password = BCrypt::Password.create(new_user.password)
  
      sql = '
        INSERT INTO users (name, email, password)
          VALUES($1, $2, $3);
      '
      sql_params = [
        new_user.name,
        new_user.email,
        new_user.password
      ]
      result_set = DatabaseConnection.exec_params(sql, sql_params)

    end
  
    def sign_in(email, submitted_password)
      user = find_by_email(email)
  
      return nil if user.nil?
  
    #   encrypted_submitted_password = BCrypt::Password.create(submitted_password)
  
    #   if user.password == submitted_password
    #     # login success
    #   else
    #     # wrong password
    #   end
   end
  
    def find_by_email(email)
        sql = 'SELECT id, name, email, password FROM users WHERE email = $1;'
        result_set = DatabaseConnection.exec_params(sql, [email])
    
        user = User.new
        user.id = result_set[0]['id'].to_i
        user.name = result_set[0]['name']
        user.email = result_set[0]['email']
        user.password = result_set[0]['password']

        return user
      end
  end


