part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}

final class PromptGeneratingImageLoadState extends PromptState{

}

final class PromptGeneratingImageAssetState extends PromptState {
  final String assetPath;
  PromptGeneratingImageAssetState(this.assetPath);
}

final class PromptGeneratingImageSuccessState extends PromptState{
  final File file;
  PromptGeneratingImageSuccessState(this.file);
}

final class PromptGeneratingImageErrorState extends PromptState{

}