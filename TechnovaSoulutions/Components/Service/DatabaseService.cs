using MySqlConnector;
using TechnovaSoulutions.Components;

namespace TechnovaSoulutions.Components.Service
{
    public partial class DatabaseService
    {
        private readonly string connectionString = "server=localhost;database=company_training;uid=root;port=3306;SslMode=None;";
        public List<Product_Model> GetAllProducts()
        {
            List<Product_Model> allProducts = new();

            using MySqlConnection connection = new(connectionString);
            connection.Open();

            string sql = """
                SELECT product_id, name, category, price, stock_quantity, supplier_id
                FROM products
                """;

            using MySqlCommand command = new(sql, connection);
            using MySqlDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                Product_Model product = new Product_Model
                {
                    product_id = reader.GetInt32("product_id"),
                    name = reader.GetString("name"),
                    category = reader.GetString("category"),
                    price = reader.GetDouble("price"),
                    stock_quantity = reader.GetInt32("stock_quantity"),
                    supplier_id = reader.GetInt32("supplier_id")
                };

                allProducts.Add(product);
            }

            return allProducts;
        }
    }
}
