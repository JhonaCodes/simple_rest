mixin STCrud<T> {

  Future<List<T>> getAll();
  Future<T> getById(Object id);

  Future<bool> deleteById(Object id);
  Future<Object> save(T entity);
  Future<Object> update(T entity);

}

