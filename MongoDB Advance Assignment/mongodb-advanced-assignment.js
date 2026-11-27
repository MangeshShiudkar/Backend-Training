// ---------------------------------------------
// Task 1: Schema Validation and Data Creation
// ---------------------------------------------

// Step 1: Create/select the fresh company_advanced database
use company_advanced;
db.dropDatabase();

// Step 2: Create the validated employees collection
db.createCollection("employees", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "departmentId", "experience", "active"],
      properties: {
        name: { bsonType: "string" },
        departmentId: { bsonType: "int" },
        experience: { bsonType: "int" },
        active: { bsonType: "bool" }
      }
    }
  }
});

// Step 3: Insert the Starting Dataset
db.employees.insertMany([
  {
    _id: 1,
    name: "John",
    departmentId: 10,
    skills: ["Java", "MongoDB"],
    experience: 4,
    active: true,
    certifications: [
      { name: "MongoDB", status: "Expired", expiryYear: 2026 }
    ]
  },
  {
    _id: 2,
    name: "Alice",
    departmentId: 10,
    skills: ["Python", "MongoDB"],
    experience: 6,
    active: true,
    certifications: [
      { name: "MongoDB", status: "Active", expiryYear: 2028 }
    ]
  },
  {
    _id: 3,
    name: "David",
    departmentId: 20,
    skills: ["Communication"],
    experience: 3,
    active: false,
    certifications: [
      { name: "Communication", status: "Active", expiryYear: 2027 }
    ]
  }
]);

// // Step 4: Test the Validation Rule (Expected to fail with Document failed validation)
try {
  db.employees.insertOne({
    _id: 99,
    name: 123,
    departmentId: "HR",
    experience: "one",
    active: "yes"
  });
} catch (e) {
  print("Expected validation rejection:", e.message);
}

// Verify Task 1 state
db.employees.countDocuments();


// ---------------------------------------------
// Task 2: Advanced Array Queries and Updates
// ---------------------------------------------

// 2.1 Find One Matching Array Object
db.employees.find({
    certifications: {
        $elemMatch: { name: "MongoDB", status: "Active" }
    }
})  

// 2.2 Update One Matching Array Element
db.employees.updateOne(
    { _id: 1, "certifications.name": "MongoDB" },
    { $set: { "certifications.$.status": "Active" } }
)

// 2.3 Update Selected Array Elements
db.employees.updateOne(
  { _id: 1 },
  { $set: { "certifications.$[c].status": "Renewal Due" } },
  { arrayFilters: [{ "c.expiryYear": { $lt: 2027 } }] }
)

// Verify Task 2 final certification values
db.employees.find({}, { name: 1, certifications: 1 });

// ---------------------------------------------
// Task 3: Bulk Write Operations
// ---------------------------------------------

db.employees.bulkWrite([
  {
    updateOne: {
      filter: { name: "John" },
      update: { $inc: { experience: 1 } }
    }
  },
  {
    updateOne: {
      filter: { name: "Alice" },
      update: { $set: { active: false } }
    }
  },
  {
    insertOne: {
      document: {
        _id: 4,
        name: "Emma",
        departmentId: 20,
        skills: ["Excel"],
        experience: 2,
        active: true,
        certifications: [
          { name: "Excel", status: "Active", expiryYear: 2026 }
        ]
      }
    }
  }
]);

// verify task 3 final values
db.employees.countDocuments(); 
db.employees.find({ name: { $in: ["John", "Alice"] } }, { name: 1, experience: 1, active: 1 });


// ---------------------------------------------
// Task 4: Advanced Aggregation
// ---------------------------------------------

// Step 1: Create the Departments Collection
db.departments.insertMany([
  { _id: 10, name: "Engineering" },
  { _id: 20, name: "HR" }
]);

// 4.1 Join Employees with Departments
db.employees.aggregate([
  {
    $lookup: {
      from: "departments",
      localField: "departmentId",
      foreignField: "_id",
      as: "department"
    }
  },
  { $unwind: "$department" },
  {
    $project: { _id: 0, name: 1, departmentName: "$department.name"}
  },
  { $sort: { name: 1 } }
]);

// 4.2 Count Employees for Each Skill
db.employees.aggregate([
  { $unwind: "$skills" },
  { $group: { _id: "$skills", employeeCount: { $sum: 1 } } },
  { $sort: { employeeCount: -1, _id: 1 } }
])

// 4.3 Return Active Employees and a Count
db.employees.aggregate([
  { $match: { active: true } },
  { $facet: {
    activeEmployees: [{ $sort: { name: 1 }}, { $project: { _id: 0, name: 1 } } ],
    totalCount: [{ $count: "count" }]
  }},
])

// ---------------------------------------------
// Task 5: Indexing and Query Performance
// ---------------------------------------------

// 5.1 Create and Verify a Compound Index
db.employees.createIndex(
  { departmentId: 1, name: 1 },
)
db.employees.getIndexes();

// 5.2 Read explain("executionStats")
db.employees.find({ departmentId: 10 }).sort({ name: 1 }).explain("executionStats");

// 5.3 Create a TTL Index
db.sessions.insertOne({
  _id: 1,
  userName: "John",
  expiresAt: new Date(Date.now() + 600000)
});

db.sessions.createIndex(
  { expiresAt: 1 },
  { expireAfterSeconds: 0 }
);
db.sessions.getIndexes();