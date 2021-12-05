enum Endpoint {
  listTasks,
  createTask,
  deleteTask,
  updateTask,
  getSingleTask,
  login,
  signup

}


class EndpointPaths {
  static Map<Endpoint, String> paths = {
     Endpoint.login:'/api/v1/auth/login',
     Endpoint.signup:'/api/v1/auth/signup',

     Endpoint.listTasks:'/api/v1/user/tasks',
     Endpoint.updateTask:'/api/v1/user/tasks/:id',
     Endpoint.getSingleTask:'/api/v1/user/tasks/:id',
     Endpoint.createTask:'/api/v1/user/tasks',
     Endpoint.deleteTask:'/api/v1/user/tasks/:id',
  };

  static String? getEndpointPath(Endpoint e) {
    return paths[e];
  }
}


