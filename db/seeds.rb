role_superadmin = Role.create(name: "superadmin")
role_admin = Role.create(name: "admin")
role_support = Role.create(name: "support")

User.create(username: "sa", email: "sa@sa.com", role: role_superadmin)

User.create(username: "admin", email: "admin@admin.com", role: role_admin)

User.create(username: "matt", email: "matt@matt.com", role: role_support)

Permission.create(resource: "ApplicationPolicy", role_ids: [1, 2, 3])
Permission.create(resource: "RolePolicy", role_ids: [1, 2])
Permission.create(resource: "DashboardPolicy", role_ids: [1, 2, 3])
