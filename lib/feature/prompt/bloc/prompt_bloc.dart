import 'dart:io';

import 'package:ai_image_generator/feature/prompt/repos/prompt_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<PromptInitialEvent>((event, emit) async{
      emit(PromptGeneratingImageAssetState("images/img.png"));
    });

    on<PromptEnteredEvent>((event, emit) async{
      emit(PromptGeneratingImageLoadState());
      File? file = await PromptRepo.generateImage(event.prompt);
      if(file != null){
        emit(PromptGeneratingImageSuccessState(file));
      }else{
        emit(PromptGeneratingImageErrorState());
      }
    });
  }
}
