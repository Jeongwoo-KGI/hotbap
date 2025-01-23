import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApi {
  final String apiKey;

  GeminiApi(this.apiKey);

  Future<List<String>> getRecommendedRecipeNames(String query) async {
    final schema = Schema.array(
      description: 'List of recommended recipe names',
      items: Schema.object(properties: {
        'recipeName': Schema.string(description: 'Name of the recipe', nullable: false),
      }, requiredProperties: ['recipeName']),
    );

    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: schema,
      ),
    );

    final prompt = '쿼리를 토대로 5개의 레시피를 한글로 알려줘: $query';
    final response = await model.generateContent([Content.text(prompt)]);

    if (response.text != null) {
      final List<dynamic> responseData = json.decode(response.text!);
      return responseData.map((recipe) => recipe['recipeName'] as String).toList();
    } else {
      throw Exception('Response text is null');
    }
  }
}
