///There is a difference between having an empty form and allowing null data
///This object deals with both not filled in yet data and data that accepts nulls,
/// it describes if our Validationmodel has data or not.
abstract class HasData<T> {

}

class HasData_yes<T> implements HasData<T> {
  final T value;

  HasData_yes(this.value);
}

class HasData_none<T> implements HasData<T> {}

extension HasData_E<T> on HasData<T> {
  T valueOrDefault(T defaultValue){
    if(this is HasData_yes<T>){
      return (this as HasData_yes<T>).value;
    }

    if(this is HasData_none<T>){
      return defaultValue;
    }

    throw Exception('HasData Unexpected Type');
  }
}