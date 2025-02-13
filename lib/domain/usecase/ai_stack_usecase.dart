
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/repository/ai_stack_repository.dart';

class AiStackUsecase {
  final AiStackRepository repository;

  AiStackUsecase(this.repository);

  Future<void> executeAdd(Recipe recipe) async {
    await repository.addRecipe(recipe);
  }
}