role_superadmin_name = "superadmin"
role_admin_name = "admin"
role_support_name = "support"

Role.insert_all([{name: role_superadmin_name}, {name: role_admin_name}, {name: role_support_name}])

u = User.create(username: "sa", email: "sa@sa.com")
u.roles = [Role.find_by(name: role_superadmin_name)]

u = User.create(username: "admin", email: "admin@admin.com")
u.roles = [Role.find_by(name: role_admin_name)]

u = User.create(username: "matt", email: "matt@matt.com")
u.roles = [Role.find_by(name: role_support_name)]
