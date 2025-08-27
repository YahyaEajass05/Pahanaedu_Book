#### Pahanaedu Bill Management System

A comprehensive web-based bill management system built with Java, JSP, and MySQL. This application provides complete functionality for managing bills, items, customers, and generating detailed reports with interactive charts.

## 🚀 Features

### Core Functionality
- **Bill Management**: Create, edit, view, and delete bills
- **Item Management**: Manage inventory items with pricing and discounts
- **Customer Management**: Track customer information and billing history
- **Discount System**: Apply percentage-based discounts to individual items
- **Bulk Operations**: Update multiple bill statuses simultaneously

### Advanced Features
- **Interactive Dashboard**: Real-time charts showing revenue and transaction data
- **Status Tracking**: Monitor bill statuses (PAID, CANCELLED)
- **Audit Trail**: Track creation and modification timestamps
- **Responsive Design**: Mobile-friendly interface with modern UI
- **Data Export**: Generate reports and export billing data

## 🛠️ Technology Stack

### Backend
- **Java** - Core application logic
- **JSP (JavaServer Pages)** - Server-side rendering
- **Servlets** - HTTP request handling
- **JDBC** - Database connectivity
- **MySQL** - Database management system

### Frontend
- **HTML5/CSS3** - Structure and styling
- **JavaScript** - Interactive functionality
- **Chart.js** - Data visualization and charts
- **Bootstrap** - Responsive UI framework
- **JSTL** - JSP Standard Tag Library

### Database
- **MySQL 8.0+** - Primary database
- **Foreign Key Constraints** - Data integrity
- **Timestamp Tracking** - Audit trail support

## 📋 Prerequisites

Before running this application, make sure you have:

- **Java 8 or higher**
- **Apache Tomcat 9.0+** or similar servlet container
- **MySQL 8.0+**
- **Maven 3.6+** (for dependency management)
- **Modern web browser** (Chrome, Firefox, Safari, Edge)

## 🗄️ Database Schema

### Tables Structure

#### `bills` Table
```sql
CREATE TABLE bills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255),
    total DECIMAL(10,2) NOT NULL,
    status ENUM('PAID', 'CANCELLED') DEFAULT 'PAID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### `bill_items` Table
```sql
CREATE TABLE bill_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    item_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    discount_percentage DECIMAL(5,2) DEFAULT 0.00,
    subtotal DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES bills(id) ON DELETE CASCADE
);
```

## ⚙️ Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/bill-management-system.git
cd bill-management-system
```

### 2. Database Setup
```sql
-- Create database
CREATE DATABASE pahanaedu_shop;
USE pahanaedu_shop;

-- Create tables (run the SQL scripts in /sql/ directory)
source sql/create_tables.sql;

-- Insert sample data (optional)
source sql/sample_data.sql;
```

### 3. Configure Database Connection
Update `src/main/java/config/DatabaseConfig.java`:
```java
public class DatabaseConfig {
    private static final String URL = "jdbc:mysql://localhost:3306/pahanaedu_shop";
    private static final String USERNAME = "your_username";
    private static final String PASSWORD = "your_password";
}
```

### 4. Build the Project
```bash
# Using Maven
mvn clean install

# Or using your IDE's build tools
```

### 5. Deploy to Tomcat
- Copy the generated WAR file to Tomcat's `webapps` directory
- Start Tomcat server
- Access the application at `http://localhost:8080/bill-management-system`

## 🎯 Usage

### Creating a New Bill
1. Navigate to the Bills section
2. Click "Create New Bill"
3. Enter customer information
4. Add items with quantities and prices
5. Apply discounts if needed
6. Save the bill

### Managing Items
1. Go to Items management
2. Add new items with pricing
3. Set discount percentages
4. Update inventory as needed

### Dashboard Analytics
- View real-time revenue charts
- Monitor transaction trends
- Track bill status distribution
- Export reports for analysis

### Bulk Operations
1. Select multiple bills using checkboxes
2. Choose bulk action (Update Status)
3. Apply changes to selected bills

## 📊 API Endpoints

### Bill Management
- `GET /bills` - List all bills
- `POST /bills` - Create new bill
- `GET /bills/{id}` - Get specific bill
- `PUT /bills/{id}` - Update bill
- `DELETE /bills/{id}` - Delete bill

### Item Management
- `GET /items` - List all items
- `POST /items` - Create new item
- `PUT /items/{id}` - Update item
- `DELETE /items/{id}` - Delete item

### Reports
- `GET /reports/dashboard` - Dashboard data
- `GET /reports/revenue` - Revenue analytics
- `GET /reports/export` - Export data

## 🎨 UI Components

### Dashboard Features
- Revenue line chart with dual Y-axis
- Transaction volume tracking
- Status distribution pie chart
- Recent bills table
- Quick action buttons

### Interactive Elements
- Modal dialogs for bill editing
- Tooltip information
- Responsive data tables
- Search and filter functionality
- Pagination for large datasets

## 🔧 Configuration

### Application Properties
```properties
# Database Configuration
db.url=jdbc:mysql://localhost:3306/pahanaedu
db.username=root
db.password=password
db.driver=com.mysql.cj.jdbc.Driver

```

### Chart Configuration
- Chart.js for data visualization
- Responsive design for all screen sizes
- Customizable color schemes
- Real-time data updates

## 🐛 Troubleshooting

### Common Issues

**Database Connection Failed**
- Check MySQL service is running
- Verify database credentials
- Ensure database exists

**Charts Not Loading**
- Check Chart.js library inclusion
- Verify data format in JavaScript
- Check browser console for errors

**Foreign Key Constraint Errors**
- Delete child records before parent records
- Use proper deletion order (bill_items → bills)

**JSP Compilation Errors**
- Check JSTL library inclusion
- Verify taglib declarations
- Ensure proper Java syntax

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

### Code Style Guidelines
- Use Java naming conventions
- Comment complex business logic
- Follow MVC architecture patterns
- Write unit tests for new features


## 👥 Support

For support and questions:
- **Email**: eajassyahya@gmail.com

## 🚀 Future Enhancements

- [ ] PDF invoice generation
- [ ] Email notification system
- [ ] Multi-currency support
- [ ] REST API documentation
- [ ] Mobile app integration
- [ ] Advanced reporting features
- [ ] User authentication system
- [ ] Multi-tenant support

## 📈 Version History

- **v1.0.0** - Initial release with basic bill management
- **v1.1.0** - Added discount system and bulk operations
- **v1.2.0** - Dashboard analytics and charts
- **v1.3.0** - Responsive design improvements

---

**Made with ❤️ for efficient bill management**
