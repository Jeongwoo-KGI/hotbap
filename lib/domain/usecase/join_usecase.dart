abstract class JoinUseCase<Type, Params> {
  Future<Type> call(Params params);
}
