# Order Lifecycle Management System (OLMS) - Salesforce

A complete end-to-end Order-to-Cash automation built on the Salesforce Platform. This project manages the entire lifecycle of an order from creation to delivery, with automated inventory, approvals, and real-time tracking.

**Live Org:** [Add Your Dev Org Link] | **Demo Video:** [Add Loom/YouTube Link]

---

### 📸 Screenshots
| Order Creation LWC | Order Tracking Dashboard | Approval Flow |
| :---: | :---: | :---: |
| Add screenshot here | Add screenshot here | Add screenshot here |

---

### 🎯 Business Use Case
Manual order management leads to stock errors, delayed deliveries, and no visibility. This system solves it by:
1.  Validating stock before order activation
2.  Automating approvals for high-value orders
3.  Giving real-time status to customers and admins

### ✨ Key Features

#### 1. Custom Data Model
- **Objects:** `Order`, `OrderItem`, `Product2`, `Pricebook`
- **Fields:** Order Status (Draft -> Activated -> Shipped -> Delivered), Tracking Number, Auto-calculated Total Amount

#### 2. LWC Components (What I Built)
- `orderCreator`: For Account page. Add multiple products with quantity and create Order + OrderItems in one click. Uses `createOrderWithItems` Apex method.
- `orderTracker`: Shows real-time order status with progress indicator (SLDS Path). Uses `@wire getRecord`.
- `orderManagementDashboard`: Admin dashboard with total orders, revenue, and pending approvals.

#### 3. Backend Automation - Apex
- `OrderTrigger` (Bulkified, Handler Pattern): 
    - On Activation: Deducts stock from Product, prevents activation if out-of-stock.
    - On Shipment: Auto-generates tracking number and sends email.
- `OrderManagementController`: AuraEnabled methods for LWC, with proper try-catch and security (