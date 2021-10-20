module Api::V1::ApiConstants
  PATH_MAP = {
    users: {
      index: ["name", "email"],
      create: [
        "name", "password", "email", "role",
      ],
      destroy: ["id"],
      update: ["name", "email", "password"],
    },
    orders: {
      index: ["user_id", "status", "address"],
    },
  }
end
