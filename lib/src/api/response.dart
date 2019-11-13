class ResponseAPI<T>{
  bool ok;
  String errorMsg;
  T result;

  ResponseAPI.ok(this.result){
    ok = true;
  }

  ResponseAPI.error(this.errorMsg){
    ok = false;
  }
  
} 