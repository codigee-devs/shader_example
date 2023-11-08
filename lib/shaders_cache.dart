import 'dart:ui';

class ShadersCache {
  FragmentShader get cosineMoon => _cosineMooon;
  FragmentShader get sceneIsDead => _sceneIsDead;

  late final FragmentShader _cosineMooon;
  late final FragmentShader _sceneIsDead;

  Future<void> initialize() async {
    _cosineMooon = await FragmentShaderLoader.load(
      'shaders/cosine_moon.frag',
    );
    _sceneIsDead = await FragmentShaderLoader.load(
      'shaders/scene_is_dead.frag',
    );
  }
}

class FragmentShaderLoader {
  static Future<FragmentShader> load(String path) {
    return FragmentProgram.fromAsset(path)
        .then((value) => value.fragmentShader());
  }
}
