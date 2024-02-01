role_superadmin = Role.create(name: "superadmin")
role_admin = Role.create(name: "admin")
role_support = Role.create(name: "support")

User.create(username: "sa", email: "sa@sa.com", role: role_superadmin)

User.create(username: "admin", email: "admin@admin.com", role: role_admin)

User.create(username: "matt", email: "matt@matt.com", role: role_support)

Permission.create(resource: Adminit::ApplicationPolicy.identifier, role_ids: [1, 2, 3])
Permission.create(resource: Adminit::RolePolicy.identifier, role_ids: [1, 2])
Permission.create(resource: Adminit::PermissionPolicy.identifier, role_ids: [1])
Permission.create(resource: Adminit::DashboardPolicy.identifier, role_ids: [1, 2, 3])
