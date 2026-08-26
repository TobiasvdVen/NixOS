use std::path::PathBuf;

use egui::Color32;
use nixos_tools_core::flake::NixosConfiguration;
use nixos_tools_core::hardware_configuration_source::HardwareConfigurationSource;
use nixos_tools_core::rebuild_action::RebuildAction;
use nixos_tools_core::rebuild_configuration::RebuildConfiguration;
use nixos_tools_core::rebuild_mode::RebuildMode;
use nixos_tools_core::rebuild_target::RebuildTarget;

use crate::app_model::AppModel;

#[derive(Default)]
pub struct View
{
    configuration: Option<RebuildConfiguration>,
    rebuild_mode: RebuildMode
}

impl View
{
    pub fn ui(&mut self, ui: &mut egui::Ui, model: &AppModel) -> Option<RebuildAction>
    {
        _ = ui.label("Command: rebuild");

        _ = egui::ComboBox::from_label("Configuration")
            .selected_text(
                self.configuration
                    .as_ref()
                    .map_or_default::<&str, _>(|c| &c.name)
            )
            .show_ui(ui, |ui| {
                for configuration in model.rebuild_configurations.iter()
                {
                    _ = ui.selectable_value(
                        &mut self.configuration,
                        Some(configuration.clone()),
                        &configuration.name
                    );
                }
            });

        _ = egui::ComboBox::from_label("Mode")
            .selected_text(self.rebuild_mode.to_string().as_str())
            .show_ui(ui, |ui| {
                self.selectable_rebuild_mode(ui, RebuildMode::Switch);
                self.selectable_rebuild_mode(ui, RebuildMode::Test);
                self.selectable_rebuild_mode(ui, RebuildMode::DryActivate);
            });

        if ui.button("GO").clicked()
        {
            return Some(RebuildAction {
                mode: self.rebuild_mode.clone(),
                target: RebuildTarget::ThisMachine,
                hardware_configuration_source: Some(HardwareConfigurationSource::Generate),
                flake_path: PathBuf::new()
            });
        }

        _ = ui.separator();

        _ = match &model.last_result
        {
            Some(Ok(content)) => ui.colored_label(Color32::GREEN, content),
            Some(Err(error)) => ui.colored_label(Color32::RED, error.to_string()),
            None => ui.label("...")
        };

        None
    }

    fn selectable_rebuild_mode(&mut self, ui: &mut egui::Ui, rebuild_mode: RebuildMode)
    {
        let text = rebuild_mode.to_string();

        _ = ui.selectable_value(&mut self.rebuild_mode, rebuild_mode, &text);
    }
}
