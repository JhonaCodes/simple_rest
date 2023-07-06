/// ****************************************************
///                                                    *
///               By: JhonaCode                        *
///               Web:     https://jhonacode.com       *
///               Email:   jhonacode2020@gmail.com     *
///               Twitter: @jhonacode                  *
///               Facebook: @jhonacode                 *
///               Telegram: @jhonacode                 *
///               March 2023                           *
///                                                    *
///         Licensed under the MIT License             *
///                                                    *
/// ****************************************************

abstract class STCrud<T> {

  dynamic getAll();
  dynamic getById<P1>(P1 id);
  dynamic deleteById<P2>(P2 id);
  dynamic save(T entity);
  dynamic updateAllData<P3>(P3 entity);
  dynamic updateSpecificData<P3>(P3 entity);

}

