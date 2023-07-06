mixin STCrud<T> {

  Future<List<Object>> getAll();
  Future<Object> getById(Object id);

  Future<Object> deleteById(Object id);
  Future<Object> save(T entity);
  Future<Object> update(Object entity);

}

