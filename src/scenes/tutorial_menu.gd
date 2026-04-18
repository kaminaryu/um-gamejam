extends CanvasLayer

@onready var tutorial_select = $Control/TextureRect/SelectTutorial;
@onready var tutorial_page = $Control/TextureRect/TutorialPage;

@onready var title = $Control/TextureRect/TutorialPage/TutorialFrame/ContentMargin/Content/Title;
@onready var image = $Control/TextureRect/TutorialPage/TutorialFrame/ContentMargin/Content/Image;
@onready var desc = $Control/TextureRect/TutorialPage/TutorialFrame/ContentMargin/Content/Description;

@onready var animation_player = $AnimationPlayer


const categories = ['enemies', 'controls', 'mechanics'];

var currentIndex = 0;
var lastItem: int;

var tutorial_data: Array[TutorialData];

func _ready() -> void :
    hide();

func close_tutorial() -> void:
    hide()

func go_back() -> void:
    tutorial_select.show();
    tutorial_page.hide();
    currentIndex = 0;
    lastItem = 0;
    tutorial_data.clear();


func _on_close_pressed() -> void:
    animation_player.play("close");


func _on_enemies_pressed() -> void:
    show_tutorial('enemies');

func show_tutorial_select() -> void:
    show();
    animation_player.play("reveal");

func show_tutorial(category: String) -> void:
    if (category not in categories):
        return
    
    var path = "res://assets/tutorial/" + category
    var files = DirAccess.get_files_at(path)
    lastItem = files.size();
    
    for file in files:
        if file.ends_with(".tres") or file.ends_with(".tres.remap"):
            var clean_file = file.trim_suffix(".remap");
            var full_path = path + "/" + clean_file
            var loaded_data = load(full_path) as TutorialData;
            
            if loaded_data:
                tutorial_data.append(loaded_data)
    
    tutorial_select.hide();
    tutorial_page.show();
    
    assign_data();
    
    
func assign_data() -> void:
    title.text = tutorial_data[currentIndex].title;
    image.texture = tutorial_data[currentIndex].picture;
    desc.text = tutorial_data[currentIndex].description;
    
    
func _on_left_pressed() -> void:
    if (currentIndex == 0): return;
    
    currentIndex -= 1;
    assign_data();
    
func _on_right_pressed() -> void:
    if (currentIndex == lastItem-1): return;
    
    currentIndex += 1;
    assign_data();
    
    


func _on_controls_pressed() -> void:
    show_tutorial('controls');


func _on_mechanism_pressed() -> void:
    show_tutorial('mechanics');


func _on_close2_pressed() -> void:
    go_back();


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == 'close'):
        close_tutorial();
