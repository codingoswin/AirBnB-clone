require_relative 'user'
require_relative 'database_connection'


class UserRepository
    def all
      users = []
      sql = 'SELECT id, username, email, password FROM users;'
      result_set = DatabaseConnection.exec_params(sql, [])
      result_set.each do |record| 
        user = User.new
        user.username = record['username']
        user.email = record['email']
        user.password = record['password']
        users << user
      end 
      return users
    end 

  
    def create(new_user)
      sql = '
        INSERT INTO users (username, email, password)
          VALUES($1, $2, $3);
      '
      sql_params = [
        new_user.username,
        new_user.email,
        new_user.password
      ]
      result_set = DatabaseConnection.exec_params(sql, sql_params)

    end
end

