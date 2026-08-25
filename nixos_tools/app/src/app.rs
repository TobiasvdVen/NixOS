use eframe::App;

use crate::app_model::AppModel;
use crate::view::View;

#[derive(Default)]
pub struct NixosToolsApp
{
    view: View,
    model: AppModel
}

impl App for NixosToolsApp
{
    fn ui(&mut self, ui: &mut egui::Ui, _frame: &mut eframe::Frame)
    {
        if let Some(action) = self.view.ui(ui, &self.model)
        {
            self.model.update(action);
        }
    }
}
